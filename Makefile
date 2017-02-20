
all: clean compile build-java dist-php dist-java dist-js dist-docs

compile:
	thrift -r --gen php:server,psr4 src/Post.thrift
	thrift -r --gen java src/Post.thrift
	thrift -r --gen js:jquery src/Post.thrift
	thrift -r --gen html:standalone src/Post.thrift

build-java:
	mkdir -p lang/java/build
	javac -cp lang/java/libthrift-1.0.0.jar:lang/java/slf4j.jar -encoding utf8 -d lang/java/build gen-java/kr/appkr/thrift/*/*.java
	jar cvf lang/java/post-thrift.jar -C lang/java/build/ kr

dist-php:
	mv gen-php dist-php

dist-java:
	[ -d dist-java/lib ] || mkdir -p dist-java/lib
	mv gen-java dist-java/src
	mv lang/java/post-thrift.jar dist-java/lib

dist-js:
	mv gen-js dist-js

dist-docs:
	mv gen-html docs

clean:
	rm -rf gen-* dist-* docs
	rm -rf lang/java/build lang/java/post-thrift.jar
