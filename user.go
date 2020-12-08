package main

import "time"

type User struct {
	Username       string        `json:"username"`
	Password       string        `json:"password"`
	ChromeHeadless bool          `json:"headless"`
	Debug          bool          `json:"debug"`
	Timeout        time.Duration `json:"timeout"`
}

func NewUser() *User {
	return &User{}
}
