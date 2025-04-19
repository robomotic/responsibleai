package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"os"
	"strings"
	"time"
)

const UserAgent = "AI-Training-Crawler"

type Provenance struct {
	URL        string            `json:"url"`
	CheckedAt  string            `json:"checked_at"`
	Allowed    bool              `json:"allowed"`
	Directives map[string]string `json:"directives"`
}

func fetchRobotsTxt(u string) string {
	parsed, _ := url.Parse(u)
	robotsURL := fmt.Sprintf("%s://%s/robots.txt", parsed.Scheme, parsed.Host)
	resp, err := http.Get(robotsURL)
	if err != nil || resp.StatusCode != 200 {
		return ""
	}
	defer resp.Body.Close()
	scanner := bufio.NewScanner(resp.Body)
	var sb strings.Builder
	for scanner.Scan() {
		sb.WriteString(scanner.Text() + "\n")
	}
	return sb.String()
}

func parseAiTrainingDirectives(robotsTxt string) map[string]string {
	directives := make(map[string]string)
	scanner := bufio.NewScanner(strings.NewReader(robotsTxt))
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "AI-Training") || strings.HasPrefix(line, "User-agent") {
			parts := strings.SplitN(line, ":", 2)
			if len(parts) == 2 {
				directives[strings.TrimSpace(parts[0])] = strings.TrimSpace(parts[1])
			}
		}
	}
	return directives
}

func isPathAllowed(directives map[string]string, path string) bool {
	ua := directives["User-agent"]
	if ua != UserAgent {
		return false
	}
	allow := directives["Allow"]
	disallow := directives["Disallow"]
	if disallow != "" && strings.HasPrefix(path, disallow) {
		return false
	}
	if allow != "" && strings.HasPrefix(path, allow) {
		return true
	}
	return false
}

func storeProvenance(url string, allowed bool, directives map[string]string) {
	record := Provenance{
		URL:        url,
		CheckedAt:  time.Now().UTC().Format(time.RFC3339),
		Allowed:    allowed,
		Directives: directives,
	}
	f, _ := os.OpenFile("provenance.json", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	defer f.Close()
	enc := json.NewEncoder(f)
	enc.Encode(record)
}

func main() {
	testURL := "http://127.0.0.1:5000/blog/article1"
	if len(os.Args) > 1 {
		testURL = os.Args[1]
	}
	robotsTxt := fetchRobotsTxt(testURL)
	directives := parseAiTrainingDirectives(robotsTxt)
	parsed, _ := url.Parse(testURL)
	allowed := isPathAllowed(directives, parsed.Path)
	fmt.Printf("AI-Training permission for %s: %v\n", testURL, allowed)
	storeProvenance(testURL, allowed, directives)
}
