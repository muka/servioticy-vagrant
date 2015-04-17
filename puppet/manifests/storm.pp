class servioticy::storm {

    include servioticy::params

    archive { 'apache-storm-$storm_version':
      ensure    => present,
      follow_redirects => true,
      checksum  => false,
      url       => $storm_url,
      target    => '$installdir',
      timeout   => 0,
      src_target=> '$downloaddir',
      require   => Class["servioticy::files","servioticy::packages"],
    }

}
