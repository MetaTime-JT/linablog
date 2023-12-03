# ==============================================================================
# 定义全局 Makefile 变量方便后面引用

# 以下两行 Makefile 代码，最终获取了项目根目录的绝对路径：
COMMON_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
# 项目根目录
ROOT_DIR := $(abspath $(shell cd $(COMMON_SELF_DIR)/ && pwd -P))
# 构建产物、临时文件存放目录
OUTPUT_DIR := $(ROOT_DIR)/_output

# ==============================================================================
# 定义 Makefile all 伪目标，执行 `make` 时，会默认会执行 all 伪目标
.PHONY: all
all: add-copyright format build
# 按顺序执行：add-copyright（添加版权头信息）、format（格式化 Go 源码）、build（编译源码）

# ==============================================================================
# 定义其他需要的伪目标

.PHONY: build
build: tidy # 编译源码，依赖 tidy 目标自动添加/移除依赖包.
        @go build -v -o $(OUTPUT_DIR)/linablog $(ROOT_DIR)/cmd/linablog/main.go
# 通过 $(ROOT_DIR) 变量来引用文件的绝对路径，避免使用相对路径带来的潜在问题

.PHONY: format
format: # 格式化 Go 源码.
        @gofmt -s -w ./

.PHONY: add-copyright
add-copyright: # 添加版权头信息.
        @addlicense -v -f $(ROOT_DIR)/scripts/boilerplate.txt $(ROOT_DIR) --skip-dirs=third_party,vendor,$(OUTPUT_DIR)

.PHONY: swagger
swagger: # 启动 swagger 在线文档.
        @swagger serve -F=swagger --no-open --port 65534 $(ROOT_DIR)/api/openapi/openapi.yaml

.PHONY: tidy
tidy: # 自动添加/移除依赖包.
        @go mod tidy

.PHONY: clean
clean: # 清理构建产物、临时文件等.
        @-rm -vrf $(OUTPUT_DIR)
# - 语法可以确保在临时目录不存在时，Makefile 执行结果仍然是成功的（实现幂等清理的效果）