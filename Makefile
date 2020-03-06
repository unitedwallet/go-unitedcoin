# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gun android ios gun-cross evm all test clean
.PHONY: gun-linux gun-linux-386 gun-linux-amd64 gun-linux-mips64 gun-linux-mips64le
.PHONY: gun-linux-arm gun-linux-arm-5 gun-linux-arm-6 gun-linux-arm-7 gun-linux-arm64
.PHONY: gun-darwin gun-darwin-386 gun-darwin-amd64
.PHONY: gun-windows gun-windows-386 gun-windows-amd64

GOBIN = ./build/bin
GO ?= latest

gun:
	build/env.sh go run build/ci.go install ./cmd/gun
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gun\" to launch gun."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gun.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Geth.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

lint: ## Run linters.
	build/env.sh go run build/ci.go lint

clean:
	./build/clean_go_build_cache.sh
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

gun-cross: gun-linux gun-darwin gun-windows gun-android gun-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gun-*

gun-linux: gun-linux-386 gun-linux-amd64 gun-linux-arm gun-linux-mips64 gun-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-*

gun-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gun
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep 386

gun-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gun
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep amd64

gun-linux-arm: gun-linux-arm-5 gun-linux-arm-6 gun-linux-arm-7 gun-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep arm

gun-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gun
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep arm-5

gun-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gun
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep arm-6

gun-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gun
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep arm-7

gun-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gun
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep arm64

gun-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gun
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep mips

gun-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gun
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep mipsle

gun-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gun
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep mips64

gun-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gun
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gun-linux-* | grep mips64le

gun-darwin: gun-darwin-386 gun-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gun-darwin-*

gun-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gun
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gun-darwin-* | grep 386

gun-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gun
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gun-darwin-* | grep amd64

gun-windows: gun-windows-386 gun-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gun-windows-*

gun-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gun
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gun-windows-* | grep 386

gun-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gun
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gun-windows-* | grep amd64
