class mpd (
  $ensure                           = 'installed',
  $package                          = $mpd::params::package,
  $service                          = $mpd::params::service,
  $audio_buffer_size                = $mpd::params::audio_buffer_size,
  $audio_output_format              = $mpd::params::audio_output_format,
  $auto_update                      = $mpd::params::auto_update,
  $auto_update_depth                = $mpd::params::auto_update_depth,
  $bind_to_address                  = $mpd::params::bind_to_address,
  $bind_to_address                  = $mpd::params::bind_to_address,
  $buffer_before_play               = $mpd::params::buffer_before_play,
  $connection_timeout               = $mpd::params::connection_timeout,
  $db_file                          = $mpd::params::db_file,
  $default_permissions              = $mpd::params::default_permissions,
  $filesystem_charset               = $mpd::params::filesystem_charset,
  $follow_inside_symlinks           = $mpd::params::follow_inside_symlinks,
  $follow_outside_symlinks          = $mpd::params::follow_outside_symlinks,
  $id3v1_encoding                   = $mpd::params::id3v1_encoding,
  $gapless_mp3_playback             = $mpd::params::gapless_mp3_playback,
  $group                            = $mpd::params::group,
  $log_file                         = $mpd::params::log_file,
  $log_level                        = $mpd::params::log_level,
  $max_command_list_size            = $mpd::params::max_command_list_size,
  $max_connections                  = $mpd::params::max_connections,
  $max_output_buffer_size           = $mpd::params::max_output_buffer_size,
  $max_playlist_length              = $mpd::params::max_playlist_length,
  $metadata_to_use                  = $mpd::params::metadata_to_use,
  $mixer_type                       = $mpd::params::mixer_type,
  $mixer_type                       = $mpd::params::mixer_type,
  $mixer_type                       = $mpd::params::mixer_type,
  $music_directory                  = $mpd::params::music_directory,
  $password                         = $mpd::params::password,
  $pid_file                         = $mpd::params::pid_file,
  $playlist_directory               = $mpd::params::playlist_directory,
  $port                             = $mpd::params::port,
  $replaygain                       = $mpd::params::replaygain,
  $replaygain_preamp                = $mpd::params::replaygain_preamp,
  $samplerate_converter             = $mpd::params::samplerate_converter,
  $save_absolute_paths_in_playlists = $mpd::params::save_absolute_paths_in_playlists,
  $state_file                       = $mpd::params::state_file,
  $sticker_file                     = $mpd::params::sticker_file,
  $user                             = $mpd::params::user,
  $volume_normalization             = $mpd::params::volume_normalization,
  $zeroconf_enabled                 = $mpd::params::zeroconf_enabled,
  $zeroconf_name                    = $mpd::params::zeroconf_name,
  # MPC options
  $mpc                              = false,
  $mpc_pkg                          = 'mpc',
  $mpc_ensure                       = 'installed',
) inherits ::mpd::params {

  package { $package:
    ensure => $ensure,
  }

  file { '/etc/mpd.conf':
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => template('mpd/mpd.conf.erb'),
  }

  case $ensure {
    'purged', 'absent': {
      $_ensure = 'stopped'
    }
    default: {
      # If version number is passed to ensure
      $_ensure = 'running'
    }
  }

  service { $service:
    ensure    => $_ensure,
    enable    => true,
    subscribe => File['/etc/mpd.conf'],
  }

  if $mpc {

    package { $mpc_pkg:
      ensure => $mpc_ensure,
    }

  }

}
