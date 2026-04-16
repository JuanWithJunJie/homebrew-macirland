# MacIrland Homebrew Installation
#
# NOTE: Due to Homebrew sandbox restrictions, GUI applications are better
# distributed via direct download.
#
# For MacIrland, please use direct download:
# https://github.com/JuanWithJunJie/ai-dynamic-island/releases/latest
#
# This formula provides a CLI wrapper that downloads and launches the app.

class Macirland < Formula
  desc "macOS AI CLI session observer with Dynamic Island support"
  homepage "https://github.com/JuanWithJunJie/ai-dynamic-island"
  version "0.1.0"
  url "https://github.com/JuanWithJunJie/ai-dynamic-island/releases/download/v0.1.0/MacIrland-v0.1.0-macos.zip"
  sha256 "0a8e844dd2d8340cbbf2f6493e753d017ae3ccd6edc4e1e87898510ebb9f677b"
  license "MIT"

  def install
    # Create a launcher script that downloads and opens the app
    # Use Ruby's File API to avoid sandbox issues with system commands
    wrapper_path = "#{prefix}/bin/macirland"

    # Create bin directory using Ruby (not system command)
    require 'fileutils'
    FileUtils.mkdir_p("#{prefix}/bin")

    # Write wrapper script
    File.write(wrapper_path, <<~EOS)
      #!/bin/bash
      set -e

      VERSION="#{version}"
      CACHE_DIR="$HOME/Library/Caches/MacIrland"
      APP_PATH="$CACHE_DIR/MacIrland.app"
      ZIP_PATH="$CACHE_DIR/MacIrland-v${VERSION}-macos.zip"
      DOWNLOAD_URL="https://github.com/JuanWithJunJie/ai-dynamic-island/releases/download/v${VERSION}/MacIrland-v${VERSION}-macos.zip"

      mkdir -p "$CACHE_DIR"

      if [ ! -d "$APP_PATH" ]; then
        echo "Downloading MacIrland v${VERSION}..."
        curl -L -o "$ZIP_PATH" "$DOWNLOAD_URL"
        unzip -o "$ZIP_PATH" -d "$CACHE_DIR"
      fi

      open "$APP_PATH"
    EOS
    chmod 0755, wrapper_path
  end

  def caveats
    <<~EOS
      MacIrland CLI launcher installed!

      Run 'macirland' to download (if needed) and launch the app.

      For full menu bar integration, download from:
      https://github.com/JuanWithJunJie/ai-dynamic-island/releases/latest
      Then move MacIrland.app to /Applications
    EOS
  end
end
