MODULES = Post

all: clean $(MODULES) java
	mkdir -p docs
	thrift -r --gen html:standalone -out docs src/Post.thrift
	
	mv gen-php dist-php

	mkdir -p dist-java/lib
	mv gen-java dist-java/src
	mv lang/java/post-thrift.jar dist-java/lib

$(MODULES): 
	thrift -r --gen php:server,psr4 src/Post.thrift
	thrift -r --gen java src/Post.thrift

java:
	mkdir -p lang/java/build
	javac -cp lang/java/libthrift-1.0.0.jar:lang/java/slf4j.jar -encoding utf8 -d lang/java/build gen-java/kr/appkr/thrift/*/*.java
	jar cvf lang/java/post-thrift.jar -C lang/java/build/ kr

clean: clean-java
	rm -rf gen-* dist-* docs

clean-java:
	rm -rf lang/java/build lang/java/post-thrift.jar