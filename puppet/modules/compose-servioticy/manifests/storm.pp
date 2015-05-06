class servioticy::storm {

    archive { "apache-storm-{$servioticy::params::storm_version}":
      ensure            => present,
      follow_redirects  => true,
      checksum          => false,
      url               => $servioticy::params::storm_url,
      target            => $servioticy::params::installdir,
      timeout           => 0,
      src_target        => $servioticy::params::downloaddir,
    }

}