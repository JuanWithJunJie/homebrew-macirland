class Macirland < Formula
  desc "macOS AI CLI session observer with Dynamic Island support"
  homepage "https://github.com/JuanWithJunJie/ai-dynamic-island"
  version "0.1.0"
  url "https://github.com/JuanWithJunJie/ai-dynamic-island/releases/download/v0.1.0/MacIrland-v0.1.0-macos.zip"
  sha256 "0a8e844dd2d8340cbbf2f6493e753d017ae3ccd6edc4e1e87898510ebb9f677b"
  license "MIT"

  def install
    # Download the zip from GitHub releases to a known location
    zip_path = HOMEBREW_CACHE/"MacIrland-v#{version}-macos.zip"
    ohai "Downloading MacIrland v#{version}..."
    system "curl", "-L", "-o", zip_path.to_s, "https://github.com/JuanWithJunJie/ai-dynamic-island/releases/download/v#{version}/MacIrland-v#{version}-macos.zip"

    # Extract the app bundle to a staging directory
    staging_dir = HOMEBREW_PREFIX/"var/tmp/macirland-staging"
    system "rm", "-rf", staging_dir.to_s
    system "mkdir", "-p", staging_dir.to_s
    system "unzip", "-o", zip_path.to_s, "-d", staging_dir.to_s

    # Move app to /Applications (remove existing first)
    ohai "Installing MacIrland.app to /Applications..."
    system "rm", "-rf", "/Applications/MacIrland.app"
    system "mv", "#{staging_dir}/MacIrland.app", "/Applications/MacIrland.app"
    system "rm", "-rf", staging_dir.to_s
  end

  def post_install
    # Install Claude Code hook
    hook_dir = HOMEBREW_PREFIX/".claude/hooks"
    hook_script = hook_dir/"macirland.py"

    unless hook_script.exist?
      ohai "Installing Claude Code hook..."
      hook_dir.mkpath unless hook_dir.exist?
      app_hook = "/Applications/MacIrland.app/Contents/Resources/Scripts/macirland-hook.py"
      if File.exist?(app_hook)
        FileUtils.cp(app_hook, hook_script)
        chmod 0755, hook_script
      end
    end
  end

  def caveats
    <<~EOS
      MacIrland has been installed to /Applications.

      To enable Claude Code integration:
      1. Restart Claude Code
      2. The hook should be installed automatically

      If the hook is not working, run:
        bash /Applications/MacIrland.app/Contents/Resources/Scripts/install-hooks.sh

      You may need to grant Automation permissions in:
        System Settings > Privacy & Security > Automation > MacIrland
    EOS
  end
end
