if $facts['os']['family'] == 'windows' {
  Package {
    provider => chocholatey,
  }
}

include nginx
