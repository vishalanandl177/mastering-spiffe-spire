// Lab 3: mTLS Server
// Run with: go run server.go
package main

import (
	"crypto/tls"
	"crypto/x509"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	// Load server certificate
	cert, err := tls.LoadX509KeyPair("certs/server.crt", "certs/server.key")
	if err != nil {
		log.Fatalf("Failed to load server cert: %v", err)
	}

	// Load CA cert to verify clients
	caCert, err := ioutil.ReadFile("certs/ca.crt")
	if err != nil {
		log.Fatalf("Failed to read CA cert: %v", err)
	}
	caPool := x509.NewCertPool()
	caPool.AppendCertsFromPEM(caCert)

	// mTLS configuration: REQUIRE client cert
	tlsConfig := &tls.Config{
		Certificates: []tls.Certificate{cert},
		ClientCAs:    caPool,
		ClientAuth:   tls.RequireAndVerifyClientCert, // <-- mTLS!
		MinVersion:   tls.VersionTLS13,
	}

	server := &http.Server{
		Addr:      ":8443",
		TLSConfig: tlsConfig,
		Handler: http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			// Extract client SPIFFE ID from cert
			if len(r.TLS.PeerCertificates) > 0 {
				cert := r.TLS.PeerCertificates[0]
				for _, uri := range cert.URIs {
					fmt.Fprintf(w, "Hello from server! Client SPIFFE ID: %s\n", uri.String())
					return
				}
			}
			fmt.Fprintln(w, "Hello! No SPIFFE ID found in client cert.")
		}),
	}

	fmt.Println("mTLS server starting on :8443")
	log.Fatal(server.ListenAndServeTLS("", ""))
}
