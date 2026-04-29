package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"github.com/spiffe/go-spiffe/v2/spiffegrpc/grpccredentials"
	"github.com/spiffe/go-spiffe/v2/spiffeid"
	"github.com/spiffe/go-spiffe/v2/workloadapi"
	"google.golang.org/grpc"
)

func main() {
	ctx := context.Background()
	source, err := workloadapi.NewX509Source(ctx)
	if err != nil { log.Fatal(err) }
	defer source.Close()

	creds := grpccredentials.MTLSServerCredentials(source, source, spiffeid.MatcherAny())
	srv := grpc.NewServer(grpc.Creds(creds))

	lis, err := net.Listen("tcp", ":50051")
	if err != nil { log.Fatal(err) }
	fmt.Println("gRPC server listening on :50051 with mTLS")
	srv.Serve(lis)
}
