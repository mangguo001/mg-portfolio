#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
七牛云文件上传脚本
自动上传 assets 和 _data 文件夹中的所有文件到七牛云
"""

import os
import json
import sys
from qiniu import Auth, put_file, BucketManager, build_batch_stat
from qiniu import put_data
import mimetypes

def load_config():
    """加载配置文件"""
    config_path = os.path.join(os.path.dirname(__file__), 'qiniu-config.json')
    if not os.path.exists(config_path):
        print(f"❌ 配置文件不存在: {config_path}")
        print("请先创建 qiniu-config.json 文件")
        sys.exit(1)
    
    with open(config_path, 'r', encoding='utf-8') as f:
        config = json.load(f)
    
    required_keys = ['access_key', 'secret_key', 'bucket_name', 'region']
    for key in required_keys:
        if key not in config or not config[key]:
            print(f"❌ 配置文件缺少必需项: {key}")
            sys.exit(1)
    
    return config

def get_mime_type(filename):
    """获取文件的 MIME 类型"""
    mime_type, _ = mimetypes.guess_type(filename)
    if not mime_type:
        # 根据扩展名设置默认 MIME 类型
        ext = os.path.splitext(filename)[1].lower()
        mime_map = {
            '.mp4': 'video/mp4',
            '.jpg': 'image/jpeg',
            '.jpeg': 'image/jpeg',
            '.png': 'image/png',
            '.gif': 'image/gif',
            '.json': 'application/json',
            '.html': 'text/html',
            '.css': 'text/css',
            '.js': 'application/javascript'
        }
        mime_type = mime_map.get(ext, 'application/octet-stream')
    return mime_type

def upload_file(q, bucket_name, local_path, remote_path):
    """上传单个文件"""
    try:
        # 获取文件的 MIME 类型
        mime_type = get_mime_type(local_path)
        
        # 生成上传 token
        token = q.upload_token(bucket_name, remote_path, 3600)
        
        # 上传文件
        ret, info = put_file(token, remote_path, local_path, mime_type=mime_type)
        
        if ret and ret.get('key'):
            return True, None
        else:
            return False, info
    except Exception as e:
        return False, str(e)

def upload_single_file(q, bucket_name, local_path, remote_path):
    """上传单个文件（带存在性检查和日志）"""
    if not os.path.exists(local_path):
        print(f"⚠️  文件不存在，跳过: {local_path}")
        return False, "文件不存在"
    
    print(f"📤 上传单文件: {local_path} -> {remote_path}")
    success, error = upload_file(q, bucket_name, local_path, remote_path)
    if success:
        print("   ✅ 成功")
    else:
        print(f"   ❌ 失败: {error}")
    return success, error

def upload_directory(q, bucket_name, local_dir, remote_prefix=''):
    """上传整个目录"""
    uploaded = []
    failed = []
    
    # 遍历目录
    for root, dirs, files in os.walk(local_dir):
        for file in files:
            local_path = os.path.join(root, file)
            
            # 计算相对路径
            rel_path = os.path.relpath(local_path, local_dir)
            # 转换为 Unix 风格的路径（七牛云使用 / 作为分隔符）
            remote_path = os.path.join(remote_prefix, rel_path).replace('\\', '/')
            
            print(f"📤 上传: {rel_path} -> {remote_path}")
            
            success, error = upload_file(q, bucket_name, local_path, remote_path)
            
            if success:
                uploaded.append(remote_path)
                print(f"   ✅ 成功")
            else:
                failed.append((remote_path, error))
                print(f"   ❌ 失败: {error}")
    
    return uploaded, failed

def main():
    print("=" * 60)
    print("🚀 七牛云文件上传工具")
    print("=" * 60)
    print()
    
    # 加载配置
    print("📋 加载配置...")
    config = load_config()
    print(f"   存储空间: {config['bucket_name']}")
    print(f"   存储区域: {config['region']}")
    print()
    
    # 初始化七牛云认证
    q = Auth(config['access_key'], config['secret_key'])
    
    # 检查文件是否存在
    script_dir = os.path.dirname(os.path.abspath(__file__))
    assets_dir = os.path.join(script_dir, 'assets')
    data_dir = os.path.join(script_dir, '_data')
    
    if not os.path.exists(assets_dir):
        print(f"❌ assets 文件夹不存在: {assets_dir}")
        sys.exit(1)
    
    if not os.path.exists(data_dir):
        print(f"❌ _data 文件夹不存在: {data_dir}")
        sys.exit(1)
    
    print("📁 开始上传文件...")
    print()
    
    # 上传 assets 文件夹
    print("📦 上传 assets 文件夹...")
    assets_uploaded, assets_failed = upload_directory(q, config['bucket_name'], assets_dir, 'assets')
    print()
    
    # 上传 _data 文件夹
    print("📦 上传 _data 文件夹...")
    data_uploaded, data_failed = upload_directory(q, config['bucket_name'], data_dir, '_data')
    print()
    
    # 上传额外的单个文件（例如 index.html）
    extra_files = [
        (os.path.join(script_dir, 'index.html'), 'index.html'),
    ]

    extra_uploaded = []
    extra_failed = []
    print("📄 上传单文件...")
    for local_path, remote_path in extra_files:
        success, error = upload_single_file(q, config['bucket_name'], local_path, remote_path)
        if success:
            extra_uploaded.append(remote_path)
        else:
            extra_failed.append((remote_path, error))
    print()

    # 统计结果
    total_uploaded = len(assets_uploaded) + len(data_uploaded) + len(extra_uploaded)
    total_failed = len(assets_failed) + len(data_failed) + len(extra_failed)
    
    print("=" * 60)
    print("📊 上传结果统计")
    print("=" * 60)
    print(f"✅ 成功: {total_uploaded} 个文件")
    print(f"❌ 失败: {total_failed} 个文件")
    print()
    
    if total_failed > 0:
        print("失败的文件:")
        for path, error in (assets_failed + data_failed + extra_failed):
            print(f"  - {path}: {error}")
        print()
    
    if total_uploaded > 0:
        print("✅ 上传完成！")
        print()
        print("📝 下一步:")
        print("1. 在七牛云控制台获取 CDN 域名")
        print("2. 在 deploy/index.html 中更新 qiniuCDNBase 配置")
        print("3. 测试访问网站，确认资源加载正常")
    else:
        print("❌ 没有文件上传成功，请检查配置和网络连接")

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n⚠️  上传已取消")
        sys.exit(1)
    except Exception as e:
        print(f"\n\n❌ 发生错误: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

