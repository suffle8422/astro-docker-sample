# link-like-library

Astro blog テンプレートをベースにしたブログサイト。

## 前提

- Docker Desktop が起動していること
- ホストに Node.js をインストールする必要はない（すべての npm / astro コマンドはコンテナ内で実行される）

## セットアップ

```sh
make rebuild   # 初回: イメージをビルドし dev server を起動
```

以降は `make up` で起動、`make down` で停止。

## コマンド

すべて `make` 経由で Docker コンテナ内で実行される。

| コマンド            | 説明                                                   |
| :------------------ | :----------------------------------------------------- |
| `make help`         | 利用可能なコマンド一覧を表示                           |
| `make up`           | dev server をバックグラウンド起動 (http://localhost:4321) |
| `make dev`          | dev server をフォアグラウンド起動 (Ctrl+C で停止)      |
| `make down`         | コンテナを停止・削除                                   |
| `make logs`         | dev server のログを追従表示                            |
| `make shell`        | コンテナ内にシェルを開く                               |
| `make build`        | 本番ビルドを実行 (`dist/` を生成)                      |
| `make preview`      | ビルド結果をプレビュー (http://localhost:4321)         |
| `make lint`         | ESLint を実行                                          |
| `make format`       | Prettier で整形                                        |
| `make format-check` | Prettier の整形チェック                                |
| `make install`      | 依存を追加 (例: `make install PKG=axios`)              |
| `make clean`        | volume を含めて完全にリセット                          |
| `make rebuild`      | volume リセット + イメージ再ビルド + 起動              |

### 依存パッケージを追加したら

`package.json` を更新した後は named volume に古い `node_modules` が残るため、`make rebuild` で再構築する。

## ディレクトリ構成

```text
.
├── Dockerfile.dev       # dev コンテナ定義
├── Makefile             # Docker コマンドラッパー
├── astro.config.mjs
├── compose.yaml
├── eslint.config.js
├── public/              # 静的アセット
├── src/
│   ├── assets/
│   ├── components/
│   ├── content/         # ブログ記事 (Markdown / MDX)
│   ├── layouts/
│   ├── pages/
│   └── styles/
└── tsconfig.json
```

Astro は `src/pages/` 以下の `.astro` / `.md` をルーティングする。ブログ記事は `src/content/blog/` に配置する。詳細は [Content Collections](https://docs.astro.build/en/guides/content-collections/) 参照。

## デプロイ

Cloudflare Pages の GitHub 連携で配信する。

- Build command: `npm run build`
- Build output directory: `dist`
- Environment variable: `NODE_VERSION=22`

SSG なので `@astrojs/cloudflare` adapter は不要。

## Credit

テンプレートは [Bear Blog](https://github.com/HermanMartinus/bearblog/) をベースにした Astro 公式 Blog Starter を利用。
