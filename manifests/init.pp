class mpd (
  $ensure  = 'installed',
  $package = $mpd::params::package,
) inherits ::mpd::params {

  package { $package:
    ensure => $ensure,
  }

}
