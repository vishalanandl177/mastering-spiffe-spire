package main

import (
	"context"
	"fmt"
	"io"
	"log"
	"net/http"

	"github.com/spiffe/go-spiffe/v2/spiffeid"
	"github.com/spiffe/go-spiffe/v2/spiffetls/tlsconfig"
	"github.com/spiffe/go-spiffe/v2/workloadapi"
)

const (
	socketPath = "unix:///run/spire/sockets/agent.sock"
)

// Server example
func runServer() {
	ctx := context.Background()
	source, err := workloadapi.NewX509Source(ctx, workloadapi.WithClientOptions(workloadapi.WithAddr(socketPath)))
	if err != nil {
		log.Fatalf("Unable to create X509Source: %v", err)
	}
	defer source.Close()

	// Allow only specific clients (or use AuthorizeAny)
	clientID := spiffeid.RequireFromString("spiffe://example.org/ns/default/sa/client")

	tlsConfig := tlsconfig.MTLSServerConfig(source, source, tlsconfig.AuthorizeID(clientID))
	server := &http.Server{
		Addr:      ":8443",
		TLSConfig: tlsConfig,
		Handler: http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			fmt.Fprintln(w, "Hello from SPIFFE-secured server!")
		}),
	}
	log.Println("Server listening on :8443 with mTLS")
	log.Fatal(server.ListenAndServeTLS("", ""))
}

// Client example
func runClient() {
	ctx := context.Background()
	source, err := workloadapi.NewX509Source(ctx, workloadapi.WithClientOptions(workloadapi.WithAddr(socketPath)))
	if err != nil {
		log.Fatalf("Unable to create X509Source: %v", err)
	}
	defer source.Close()

	serverID := spiffeid.RequireFromString("spiffe://example.org/ns/default/sa/server")
	tlsConfig := tlsconfig.MTLSClientConfig(source, source, tlsconfig.AuthorizeID(serverID))

	client := &http.Client{
		Transport: &http.Transport{TLSClientConfig: tlsConfig},
	}

	resp, err := client.Get("https://server:8443/")
	if err != nil {
		log.Fatalf("Request failed: %v", err)
	}
	defer resp.Body.Close()

	body, _ := io.ReadAll(resp.Body)
	fmt.Println("Response:", string(body))
}

func main() {
	if len(os.Args) > 1 && os.Args[1] == "client" {
		runClient()
	} else {
		runServer()
	}
}
