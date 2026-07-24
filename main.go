package main

import (
	"fmt"
	"math/rand"
	"os"
	"time"
)

func failRandomly() {
	fmt.Println("started...")

	rng := rand.New(rand.NewSource(time.Now().UnixNano()))

	// Generate a random float between 0.0 and 1.0
	luck := rng.Float64()

	// 50% chance of failure (you can adjust this threshold)
	if luck < 0.5 {
		fmt.Println("Job failed!")
		os.Exit(1)
	}

	fmt.Println("Job Succeeded!")
	os.Exit(0)
}

func runHelloWorldExitNormally() {
	fmt.Println("Hello World!")
	os.Exit(0)
}

func failAlways() {
	fmt.Println("always failing")
	os.Exit(1)
}

func main() {

	jobType := os.Getenv("JOB_TYPE")

	switch jobType {
	case "hello":
		runHelloWorldExitNormally()
	case "random":
		failRandomly()
	case "alwaysFail":
		failAlways()
	default:
		fmt.Println("Unknown job type!")
		os.Exit(1)
	}
}
