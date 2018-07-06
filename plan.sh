pkg_name=wp-cli
pkg_origin=timwis
pkg_version="1.5.1"
pkg_maintainer="timwis <tim@timwis.com>"
pkg_description="The command line interface for WordPress"
pkg_upstream_url="https://wp-cli.org/"
pkg_license=("MIT")
pkg_source="https://github.com/wp-cli/wp-cli/releases/download/v${pkg_version}/wp-cli-${pkg_version}.phar"
pkg_filename="wp-cli.phar"
pkg_shasum="0cc7a95e68a2ef02fc423614806c29a8e76e4ac8c9b3e67d6673635d6eaea871"
pkg_deps=(core/php)

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_check() {
  "$(pkg_path_for core/php)"/bin/php "../${pkg_filename}" --info 2>&1 | grep -q ${pkg_version}
}

do_install() {
  install --verbose -D --mode +x "../${pkg_filename}" "${pkg_prefix}/bin/${pkg_filename}"

  cat<<EOF > "${pkg_prefix}/bin/wp"
#!/bin/sh
"$(pkg_path_for core/php)"/bin/php "${pkg_prefix}/bin/${pkg_filename}" "\$@"
EOF
  chmod +x "${pkg_prefix}/bin/wp"
}
