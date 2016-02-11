# ![oya](https://cloud.githubusercontent.com/assets/4990822/12932330/a48e760c-cfc5-11e5-9b79-32532b348a53.png)

[![Required Ruby](https://img.shields.io/badge/ruby-%3E%3D%202.3.0-red.svg)](#)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![GitHub release](https://img.shields.io/github/release/844196/oya.svg)]()

![Gif](https://cloud.githubusercontent.com/assets/4990822/12924220/59689302-cf9c-11e5-9946-c359107440a0.gif)

ファイルの変更を検知し、任意のコマンドを実行します

## Why "Oya" ?

「親」という字は、親が木の上に立って子どもを見守る云々

## Install

```shellsession
$ git clone https://github.com/844196/oya && cd oya
# rake install
```

## Usage

```shellsession
$ oya ./polyaness.rb 'ruby ./polyaness.rb'
[2016-02-09 06:44:46 +0900] Handle start: ./polyaness.rb
[2016-02-09 06:44:56 +0900] Target was update!
葉書よりふーとーのがかっこいいのーん

[2016-02-09 06:48:13 +0900] Target was update!
その感じ！ウエストが引きしまるのを感じて！

[2016-02-09 06:48:25 +0900] Target was update!
YES, I AM!
```

### Option

```shellsession
$ oya --help
使用法: oya [オプション] <ターゲット> <コマンド>
    -h, --help                       この使い方を表示して終了
    -v, --version                    バージョン情報を表示して終了

使用例:
    oya ./script.rb 'ruby ./script.rb'
```

また、実行時に以下のファイルの各行をパースし、コマンドライン引数として解釈します:

* ~/.options/oya
* コマンドを実行したカレントディレクトリ下にある`.oya`

```shellsession
$ cat <<EOF>.oya
> ~/text
> date
> EOF

$ oya
[2016-02-11 22:42:11 +0900] Watch start!
```

## Author

Masaya Tk (<http://github.com/844196>)

## License

MIT

（アイコンは、[いらすとや](http://www.irasutoya.com/)のアイコンを縮小・加工して同梱しています）
