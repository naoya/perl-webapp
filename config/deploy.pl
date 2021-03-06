use strict;
use warnings;
use Cinnamon::DSL;

set application => 'perl-webapp';
set repository  => 'git://github.com/naoya/perl-webapp.git';
set user        => 'vagrant';
set password    => '';

role development => ['perlbox'], {
    deploy_to    => '/home/vagrant/perl-webapp',
    branch       => 'master',
};

task carton => {
    install => sub {
        my ($host, @args) = @_;
        my $deploy_to = get('deploy_to');
        remote {
            run ". ~/perl5/perlbrew/etc/bashrc && cd $deploy_to && carton install --deployment";
        } $host;
    },
};

task deploy  => {
    setup => sub {
        my ($host, @args) = @_;
        my $repository = get('repository');
        my $deploy_to  = get('deploy_to');
        my $branch   = 'origin/' . get('branch');
        remote {
            run "git clone $repository $deploy_to && cd $deploy_to && git checkout -q $branch";
        } $host;
    },
    update => sub {
        my ($host, @args) = @_;
        my $deploy_to = get('deploy_to');
        my $branch   = 'origin/' . get('branch');
        remote {
            run "cd $deploy_to && git fetch origin && git checkout -q $branch && git submodule update --init";
        } $host;
    },
};

task server => {
    start => sub {
        my ($host, @args) = @_;
        remote {
            sudo "supervisorctl start perl-webapp";
        } $host;
    },
    stop => sub {
        my ($host, @args) = @_;
        remote {
            sudo "supervisorctl stop perl-webapp";
        } $host;
    },
    restart => sub {
        my ($host, @args) = @_;
        remote {
            run "kill -HUP `cat /var/tmp/perl-webapp.pid`";
        } $host;
    },
    status => sub {
        my ($host, @args) = @_;
        remote {
            sudo "supervisorctl status";
        } $host;
    },
};
