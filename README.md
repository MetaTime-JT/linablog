## miniblog 项目


## 编译并运行，命令如下：
```shell
$ gofmt -s -w ./
$ go build -o _output/linablog -v cmd/linablog/main.go
command-line-arguments
$ ls _output/
miniblog
$ ./_output/linablog
Hello MiniBlog
```

## Swagger
install
```shell
$ go install github.com/go-swagger/go-swagger/cmd/swagger@latest
```
run 
```shell
swagger serve -F=swagger --no-open --port 65534 ./api/openapi/openapi.yaml
```