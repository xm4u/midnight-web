package main

import (
	"context"
	"errors"
	"fmt"
)

type User struct {
	ID   int64
	Name string
	Role Role
}

type Role string

const (
	RoleReader Role = "reader"
	RoleEditor Role = "editor"
)

type Result[T any] struct {
	Value T
	Err   error
}

type Store interface {
	Find(context.Context, int64) (User, error)
	Save(context.Context, User) error
}

func (u User) DisplayName() string {
	if u.Name == "" {
		return fmt.Sprintf("user-%d", u.ID)
	}
	return u.Name
}

func load(ctx context.Context, store Store, id int64) Result[User] {
	if id <= 0 {
		return Result[User]{Err: errors.New("invalid user id")}
	}
	user, err := store.Find(ctx, id)
	if err != nil {
		return Result[User]{Err: fmt.Errorf("find user: %w", err)}
	}
	return Result[User]{Value: user}
}

func notify(ctx context.Context, events <-chan User) {
	go func() {
		for user := range events {
			if err := ctx.Err(); err != nil {
				return
			}
			fmt.Printf("saved %s\n", user.DisplayName())
		}
	}()
}
