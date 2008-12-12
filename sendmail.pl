use strict;
use warnings;
use utf8;
use Encode;
use Email::MIME;
use Email::MIME::Creator;
use Email::Send;

# メールオブジェクトをつくる
my $mail = Email::MIME->create(
    header => [
        From    => 'from@example.com',
        To      => 'upload@example.com',
        Subject => Encode::encode('MIME-Header-ISO_2022_JP', 'コンニチワ'),
    ],
    parts => [
        encode('iso-2022-jp', '元気でやってるかー?'),
    ],
);

# Email::Send で送信する
my $sender = Email::Send->new({mailer => 'SMTP'});
$sender->mailer_args([Host => 'localhost:2525']);
$sender->send($mail);

