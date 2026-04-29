package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"github.com/spiffe/go-spiffe/v2/spiffetls/tlsconfig"
	"github.com/spiffe/go-spiffe/v2/workloadapi"
)

func main() {
	ctx := context.Background()
	source, err := workloadapi.NewX509Source(ctx)
	if err != nil {
		log.Fatalf("failed to create x509 source: %v", err)
	}
	defer source.Close()

	tlsConfig := tlsconfig.MTLSServerConfig(source, source, tlsconfig.AuthorizeAny())
	server := &http.Server{
		Addr:      ":8443",
		TLSConfig: tlsConfig,
		Handler: http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			peerID := r.TLS.PeerCertificates[0].URIs[0]
			fmt.Fprintf(w, "Hello from server! You authenticated as: %s\n", peerID)
		}),
	}

	log.Println("Server listening on :8443")
	log.Fatal(server.ListenAndServeTLS("", ""))
}
