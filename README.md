# artemis-haskell-template

Docker Container for Docker Hub

	docker build --no-cache -t artemis-haskell-template .

	docker run -itd -p 80:80 --name artemis-haskell-template artemis-haskell-template /bin/bash

	docker exec -it artemis-haskell-template /bin/bash
	
	git --version
	
	
### Publish to Dockerhub

	docker build --no-cache -t lugitan/artemis-haskel-template:<tagname> .

	docker push ls1tum/artemis-haskell-template:<tagname>
	
	
	
#### Example

	docker build --no-cache -t ls1tum/artemis-haskell-template:haskell2.5.1 .
	
	docker push ls1tum/artemis-haskell-template:haskell2.5.1