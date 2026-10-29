[33mcommit 7924afa267d818b6e5b56c1ae9076b147e1c2295[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32ms13mjl/Code-scanning-alerts-2[m[33m, [m[1;31morigin/master[m[33m, [m[1;31morigin/HEAD[m[33m)[m
Author: s13mjl <3081695297@qq.com>
Date:   Mon Oct 26 20:38:24 2026 +0800

    feat: 升级到 0.1.1，更新 webui 子模块并修复重命名后的路径引用
    
    - webui 子模块更新至 ca3c9d3：活动视图新增「年」「自始至终」与自定义日期范围
    - 修复子模块重命名为 aw-webui-zh 后 Makefile 与 src-tauri/.cargo/config.toml 中残留的 aw-webui 路径
    - 版本号 0.1.0 -> 0.1.1

[1mdiff --git a/Makefile b/Makefile[m
[1mindex ae31259..de4f79a 100644[m
[1m--- a/Makefile[m
[1m+++ b/Makefile[m
[36m@@ -14,14 +14,14 @@[m [mdev: prebuild[m
 %/.git:[m
 	git submodule update --init --recursive[m
 [m
[31m-src-tauri/icons/icon.png: aw-webui/.git[m
[32m+[m[32msrc-tauri/icons/icon.png: aw-webui-zh/.git[m
 	mkdir -p src-tauri/icons[m
[31m-	npm run tauri icon "./aw-webui/media/logo/logo.png"[m
[32m+[m	[32mnpm run tauri icon "./aw-webui-zh/media/logo/logo.png"[m
 [m
[31m-aw-webui/dist: aw-webui/.git[m
[31m-	cd aw-webui && make build[m
[32m+[m[32maw-webui-zh/dist: aw-webui-zh/.git[m
[32m+[m	[32mcd aw-webui-zh && make build[m
 [m
[31m-prebuild: aw-webui/dist node_modules src-tauri/icons/icon.png[m
[32m+[m[32mprebuild: aw-webui-zh/dist node_modules src-tauri/icons/icon.png[m
 [m
 precommit: format check[m
 [m
[1mdiff --git a/aw-webui-zh b/aw-webui-zh[m
[1mindex 24b6f69..ca3c9d3 160000[m
[1m--- a/aw-webui-zh[m
[1m+++ b/aw-webui-zh[m
[36m@@ -1 +1 @@[m
[31m-Subproject commit 24b6f69783f267e36e23f5e119e42ff6890fb659[m
[32m+[m[32mSubproject commit ca3c9d3565612a80e8c4a436fd31374e7bd1dc1a[m
[1mdiff --git a/package.json b/package.json[m
[1mindex c20268a..bfb77c3 100644[m
[1m--- a/package.json[m
[1m+++ b/package.json[m
[36m@@ -1,7 +1,7 @@[m
 {[m
   "name": "aw-tauri",[m
   "private": true,[m
[31m-  "version": "0.1.0",[m
[32m+[m[32m  "version": "0.1.1",[m
   "type": "module",[m
   "scripts": {[m
     "tauri": "tauri"[m
[1mdiff --git a/src-tauri/.cargo/config.toml b/src-tauri/.cargo/config.toml[m
[1mindex 06247df..676c01b 100644[m
[1m--- a/src-tauri/.cargo/config.toml[m
[1m+++ b/src-tauri/.cargo/config.toml[m
[36m@@ -1,2 +1,2 @@[m
 [env][m
[31m-AW_WEBUI_DIR = { value = "../aw-webui/dist", relative = true }[m
[32m+[m[32mAW_WEBUI_DIR = { value = "../aw-webui-zh/dist", relative = true }[m
[1mdiff --git a/src-tauri/Cargo.lock b/src-tauri/Cargo.lock[m
[1mindex b0fb314..b507b93 100644[m
[1m--- a/src-tauri/Cargo.lock[m
[1m+++ b/src-tauri/Cargo.lock[m
[36m@@ -457,7 +457,7 @@[m [mdependencies = [[m
 [m
 [[package]][m
 name = "aw-tauri"[m
[31m-version = "0.1.0"[m
[32m+[m[32mversion = "0.1.1"[m
 dependencies = [[m
  "aw-datastore",[m
  "aw-server",[m
[1mdiff --git a/src-tauri/Cargo.toml b/src-tauri/Cargo.toml[m
[1mindex 132a683..a2bf6c3 100644[m
[1m--- a/src-tauri/Cargo.toml[m
[1m+++ b/src-tauri/Cargo.toml[m
[36m@@ -1,6 +1,6 @@[m
 [package][m
 name = "aw-tauri"[m
[31m-version = "0.1.0"[m
[32m+[m[32mversion = "0.1.1"[m
 description = "ActivityWatch UI built with Tauri (Chinese derivative by s13mjl)"[m
 authors = ["Erik Bjäreholt <erik@bjareho.lt>", "Brian Vuku <brayo@brayo.dev>", "s13mjl (derivative)"][m
 license = "MPL-2.0"[m
[1mdiff --git a/src-tauri/tauri.conf.json b/src-tauri/tauri.conf.json[m
[1mindex 6699b57..bb6ed55 100644[m
[1m--- a/src-tauri/tauri.conf.json[m
[1m+++ b/src-tauri/tauri.conf.json[m
[36m@@ -1,7 +1,7 @@[m
 {[m
   "$schema": "https://schema.tauri.app/config/2",[m
   "productName": "aw-tauri",[m
[31m-  "version": "0.1.0",[m
[32m+[m[32m  "version": "0.1.1",[m
   "identifier": "net.activitywatch.tauri",[m
   "app": {[m
     "windows": [],[m
