module glab

go 1.21.3

replace github.com/dronm/session => /home/andrey/go/session

require github.com/dronm/session v0.0.0

replace github.com/dronm/session/redis => /home/andrey/go/session/redis

require github.com/dronm/session/redis v0.0.0

replace github.com/dronm/gobizap => /home/andrey/go/gobizap

replace github.com/dronm/gobizap/config => /home/andrey/go/gobizap/config

replace github.com/dronm/gobizap/repo/userOperation => /home/andrey/go/gobizap/repo/userOperation

replace github.com/dronm/ds => /home/andrey/go/ds

replace github.com/dronm/clbnk => /home/andrey/go/clbnk

require (
	github.com/dchest/captcha v1.0.0
	github.com/dronm/clbnk v0.0.0-20240521080150-f5bd63ba77c4
	github.com/dronm/ds v1.0.1
	github.com/dronm/gobizap v0.0.0
	github.com/dronm/gobizap/config v0.0.0-00010101000000-000000000000
	github.com/jackc/pgconn v1.14.0
	github.com/jackc/pgx/v5 v5.5.3
	github.com/labstack/gommon v0.4.0
	github.com/mssola/user_agent v0.5.3
	github.com/stvoidit/gosmtp v1.0.6
)

require (
	github.com/cespare/xxhash/v2 v2.2.0 // indirect
	github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f // indirect
	github.com/dronm/waitStrat v0.0.0-20230107030139-1373bf8a7e73 // indirect
	github.com/gobwas/httphead v0.1.0 // indirect
	github.com/gobwas/pool v0.2.1 // indirect
	github.com/gobwas/ws v1.1.0 // indirect
	github.com/h2non/filetype v1.1.3 // indirect
	github.com/jackc/chunkreader/v2 v2.0.1 // indirect
	github.com/jackc/pgio v1.0.0 // indirect
	github.com/jackc/pgpassfile v1.0.0 // indirect
	github.com/jackc/pgproto3/v2 v2.3.2 // indirect
	github.com/jackc/pgservicefile v0.0.0-20221227161230-091c0ba34f0a // indirect
	github.com/jackc/puddle/v2 v2.2.1 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.20 // indirect
	github.com/redis/go-redis/v9 v9.5.1 // indirect
	github.com/valyala/bytebufferpool v1.0.0 // indirect
	github.com/valyala/fasttemplate v1.2.1 // indirect
	golang.org/x/crypto v0.17.0 // indirect
	golang.org/x/sync v0.1.0 // indirect
	golang.org/x/sys v0.18.0 // indirect
	golang.org/x/text v0.15.0 // indirect
)
