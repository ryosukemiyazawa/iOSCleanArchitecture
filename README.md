iOS + XCodegen + CleanArchitectureのサンプル
============================================

アプリケーションをマルチモジュールで構成するサンプル。

- App アプリケーション本体。ViewControllerはここに設置

- モジュール
	- AppCore アプリケーションのCore層。各レイヤーから読み込まれる。
	- DataStore データ層。APIとの通信などはここに格納。Domain層のみ取得可能。
	- Domain ドメイン層。UseCaseなどはここに格納。
	- Presentation プリ全テーション層。App層のみ取得可能

## 各モジュールについて

Protocolのみをpublicとし、実装はモジュール内にPrivateな形で行う。

## DataStore層

- Provider.swift セットアップしたRepositoryを作る
- Repository.swift API通信、UserDefaultsへの保存などの中継を行う。
- Gateway.swift API通信を行う。実装、Protocol含めてprivateにする

## Domain層

- Provider.swift セットアップしたUseCaseを作る
- UseCase.swift Usecaseをここに格納
- Translator.swift Repositoryから取得したデータをModelに変換するTranslatorコードをここに記述

## Presentation層

- Provider.swift セットアップしたPresenterを作る
- Presenter.swift Presenterをここに格納。
- Wireframe.swift PresenterからのOutput（ViewControllerが実装する）のprotocol
- ViewModel.swift ViewModel。基本的にはpublicで行う。

