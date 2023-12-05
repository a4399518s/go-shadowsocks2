package main

import (
	"strconv"
	"time"

	"github.com/go-redis/redis"
)

var client *redis.Client
var serverId string

// 初始化连接
func initRedisClient(id string, redisHost string, redisPort int) {
	client = redis.NewClient(&redis.Options{
		Addr:     redisHost + ":" + strconv.Itoa(redisPort),
		Password: "",
		DB:       0,
	})
	serverId = id
}

func redisSet(key string, value interface{}, expiration time.Duration) (string, error) {
	return client.Set(key, value, expiration).Result()
}

func redisIncr(key string, value int64) (int64, error) {
	return client.IncrBy(key, value).Result()
}

func redisDecr(key string, value int64) (int64, error) {
	return client.DecrBy(key, value).Result()
}

func redisGet(key string) (string, error) {
	return client.Get(key).Result()
}

func redisKeyGetUp() string {
	return "g:s:" + serverId + ":up"
}
func redisKeyGetDown() string {
	return "g:s:" + serverId + ":down"
}
func redisKeyGetMax() string {
	return "g:s:" + serverId + ":max"
}
