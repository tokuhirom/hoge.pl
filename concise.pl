use strict;
use warnings;
use B::Concise qw/set_style add_callback/;

my $code = '3 + 2';
my $walker = B::Concise::compile('-exec', '_', eval "sub _ { $code }");
$walker->();

