COMPOSE := docker compose
RUN := $(COMPOSE) run --rm web

.PHONY: help up dev down logs shell build preview lint format format-check install clean rebuild

help: ## 利用可能なコマンドを表示
	@awk 'BEGIN{FS=":.*##"; printf "Usage: make <target>\n\nTargets:\n"} /^[a-zA-Z_-]+:.*##/ {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

up: ## dev server をバックグラウンド起動 (http://localhost:4321)
	$(COMPOSE) up -d

dev: ## dev server をフォアグラウンド起動 (Ctrl+C で停止)
	$(COMPOSE) up

down: ## コンテナを停止・削除
	$(COMPOSE) down

logs: ## dev server のログを追従表示
	$(COMPOSE) logs -f web

shell: ## コンテナ内にシェルを開く
	$(RUN) sh

build: ## 本番ビルドを実行 (dist/ を生成)
	$(RUN) npm run build

preview: ## ビルド結果をプレビュー (http://localhost:4321)
	$(COMPOSE) run --rm --service-ports web npm run preview -- --host 0.0.0.0

lint: ## ESLint を実行
	$(RUN) npm run lint

format: ## Prettier で整形
	$(RUN) npm run format

format-check: ## Prettier の整形チェック
	$(RUN) npm run format:check

install: ## 依存を追加 (例: make install PKG=axios)
	$(RUN) npm install $(PKG)

clean: ## volume を含めて完全にリセット
	$(COMPOSE) down -v

rebuild: ## volume リセット + イメージ再ビルド + 起動
	$(COMPOSE) down -v
	$(COMPOSE) build
	$(COMPOSE) up -d
