# inception
Docker를 사용하여 워드프레스 블로그를 위한 소규모 인프라를 구성합니다.

## Diagram
<img width="535" alt="image" src="https://github.com/yeseulgangahan/inception/assets/88709878/6093e81f-a7fb-4b4f-b1ce-1aa30b9c0f71">

- MariaDB, NGINX, Wordpress가 각각 하나의 컨테이너로 구성
- docker-network로 컨테이너 간 연결 구축

## Features
- Debian 안정버전을 사용하는 사용자 지정 Dockerfile로 각 서비스 설정
- docker compose로 여러 개의 컨테이너를 한 번에 관리
- 브라우저에서 `https://127.0.0.1:433` 혹은 `https://yehan.42.fr`로 접근 가능

## Usage
`make`

## Peer Reviews
<img width="535" alt="image" src="https://github.com/yeseulgangahan/inception/assets/88709878/503a1d39-fa51-4057-bcc0-baf978f163c2">
<img width="535" alt="image" src="https://github.com/yeseulgangahan/inception/assets/88709878/04531b61-7e89-44aa-9594-fcbe1d8d5c4c">
<img width="535" alt="image" src="https://github.com/yeseulgangahan/inception/assets/88709878/4caacbf6-411c-42e2-a366-13acf6fbd64d">

## Notion Post
