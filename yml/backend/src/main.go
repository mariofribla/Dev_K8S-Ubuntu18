package main

import (
    "encoding/json"
    "os"
    "net/http"
    "time"
)

type server struct{}

type HansOn struct {
    Time  time.Time  `json:"time"` 
    Hostname string `json:"hostname"` 
}

func  (s *server) ServeHTTP(w http.ResponseWriter, r *http.Request) {

    if r.URL.Path != "/" {
        http.NotFound(w, r)
        return
    }

    resp := HansOn{
        Time: time.Now(),
        Hostname: os.Getenv("HOSTNAME"),
    }
    jsonResp, err := json.Marshal(&resp)
    if err != nil {
        w.Write([]byte("Error"))
        return
    }
    w.WriteHeader(http.StatusOK)
    w.Header().Set("Content-Type", "application/json")
    // resp := fmt.Sprintf("La hora es %v y Hostname es %v...", time.Now(), os.Getenv("HOSTNAME"))
    //w.Write([]byte(resp))
    w.Write(jsonResp)
}

func main() {
    s := &server{}
    http.Handle("/", s)
    http.ListenAndServe(":9090", nil)
}
