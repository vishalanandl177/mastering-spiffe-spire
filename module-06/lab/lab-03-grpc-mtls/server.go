package main

import (
	"context"
	"log"
	"net"

	"github.com/spiffe/go-spiffe/v2/spiffeid"
	"github.com/spiffe/go-spiffe/v2/spiffetls/tlsconfig"
	"github.com/spiffe/go-spiffe/v2/workloadapi"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
)

func main() {
	ctx := context.Background()
	source, err := workloadapi.NewX509Source(ctx)
	if err != nil {
		log.Fatal(err)
	}
	defer source.Close()

	clientID := spiffeid.RequireFromString("spiffe://example.org/ns/default/sa/grpc-client")
	tlsConfig := tlsconfig.MTLSServerConfig(source, source, tlsconfig.AuthorizeID(clientID))

	creds := credentials.NewTLS(tlsConfig)
	server := grpc.NewServer(grpc.Creds(creds))

	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatal(err)
	}
	log.Println("gRPC server listening on :50051 with mTLS via SPIFFE")
	log.Fatal(server.Serve(lis))
}
