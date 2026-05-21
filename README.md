# first-action

新規サービス・プロジェクトの「0→1 立ち上げ」を完全自動化する [Claude Code](https://docs.claude.com/en/docs/claude-code) 用のスキルです。

ユーザーがサービスアイデアを投げた瞬間から、要件定義 → 外部レビュー → 実装フェーズ開始までを一気通貫で走らせます。

## 何をしてくれるか

`/first-action` を叩く、または「新しいサービスを作りたい」と発話するだけで、Claude Code が以下の 7 Phase を順番に実行します。

```
Phase 0: Preflight Gate         (誤起動防止 / 既存プロジェクト保護)
   ↓
Phase 1: Requirements           (Plan Mode + superpowers:brainstorming)
   ↓
Phase 2: GitHub Recon           (WebSearch で類似プロジェクト調査)
   ↓
Phase 3: Skill/MCP/Agent Scoring (find-skills + スコアリング推奨)
   ↓
Phase 4: docs/YYYY-MM-DD_First_definition.md + my_first_commit
   ↓
Phase 5: /ticket-gen            (要件のチケット分解)
   ↓
Phase 6: codex-second-opinion   (外部 AI レビュー、最大 3 周)
   ↓
Phase 7: /ko + /next            (Phase 単位の段階実装)
```

## 動作要件

- [Claude Code](https://docs.claude.com/en/docs/claude-code) CLI / VS Code 拡張
- 推奨: 以下のスキルが併せて入っていると全 Phase をフル活用できます
  - `superpowers:brainstorming`
  - `find-skills`
  - `ticket-gen`
  - `codex-second-opinion`（または `codex:*` プラグイン）
  - `ko` / `next`

これらが無くても Phase 0〜4 までは動作します。

## インストール

```bash
# ~/.claude/skills/ 配下にクローン
mkdir -p ~/.claude/skills
git clone https://github.com/Otola-Ryntaro/claude-skill-first-action.git ~/.claude/skills/first-action
```

クローン後に Claude Code を再起動すれば `/first-action` が認識されます。

## 使い方

1. **空のディレクトリ**を作って `cd` する
   ```bash
   mkdir my-new-service && cd my-new-service
   ```
2. Claude Code を起動
3. `/first-action` と入力するか、「新しいサービスを作りたい」と話しかける

あとは Claude が Phase 0 から順番に進行管理してくれます。

## 発動しないケース

- 既存プロジェクトの機能追加・バグ修正・リファクタリング
- 単発の質問、デバッグ、コードレビュー
- 既に要件定義済みのプロジェクトの実装着手

これらでは別スキル（`/ticket-gen`, `/ko` など）を直接呼び出してください。

## ディレクトリ構成

```
claude-skill-first-action/
├── SKILL.md                       # スキル本体（Phase 0〜7 の詳細手順）
├── references/
│   ├── scoring-criteria.md        # Skill/MCP/Agent のスコアリング基準
│   ├── context-hygiene.md         # コンテキスト衛生ルール
│   └── templates/
│       ├── first-definition.md    # 要件定義書テンプレ
│       ├── claude-md.md           # プロジェクト用 CLAUDE.md テンプレ
│       └── gitignore              # 推奨 .gitignore
├── scripts/
│   └── preflight.sh               # Phase 0 の安全チェック
├── LICENSE                        # MIT
└── README.md                      # このファイル
```

## ライセンス

[MIT License](LICENSE)

## 著作者

音良林太郎 ([@Otola_ryntaro](https://x.com/Otola_ryntaro))
