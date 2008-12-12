use strict;
use warnings;
use Net::SSH::Perl::Key::RSA;
use Crypt::OpenSSL::RSA;
use File::Slurp;
use Test::More tests => 1;

my $key_path = 'priv.pem';
my $message = "FUGA";

is sign_rsa(), sign_openssl();

sub sign_rsa {
    # Net::SSH::Perl::Key::RSA is based on Crypt::RSA + Convert::PEM
    my $key = Net::SSH::Perl::Key::RSA->read_private($key_path, '', \"");
    my $dgst = 'SHA1';
    my $rsa = Crypt::RSA::SS::PKCS1v15->new( Digest => $dgst );
    my $sig = $rsa->sign(
        Digest  => $dgst,
        Message => $message,
        Key     => $key->{rsa_priv}
    ) or die $rsa->errstr;
    $sig;
}

sub sign_openssl {
    my $rsa = Crypt::OpenSSL::RSA->new_private_key(join('', read_file($key_path)));
    $rsa->use_pkcs1_padding();
    my $signature = $rsa->sign($message);
    $signature;
}

