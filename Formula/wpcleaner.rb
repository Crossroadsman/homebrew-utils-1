class Wpcleaner < Formula
  desc "Wikipedia maintenance tool"
  homepage "https://en.wikipedia.org/wiki/Wikipedia:WPCleaner"

  depends_on :java => "1.8+"

  head do
    url "https://tools.wmflabs.org/wpcleaner/wpcleaner/WPCleaner.jar",
      :using => :nounzip

    # from https://tools.wmflabs.org/wpcleaner/wpcleaner/digest.txt
    %w[libs/commons-codec.jar
       libs/commons-compress.jar
       libs/commons-httpclient.jar
       libs/commons-logging.jar
       libs/gettext-commons.jar
       libs/jackson-annotations.jar
       libs/jackson-core.jar
       libs/jackson-databind.jar
       libs/jaxen.jar
       libs/jdom.jar
       libs/xercesImpl.jar
       libs/xml-apis.jar
       libs/logback-classic.jar
       libs/logback-core.jar
       libs/slf4j-api.jar
       logback.xml
       WPCleaner.png
       WPCleaner.ico
       Bot.sh
       WPCleaner.sh
       libs/LICENSE_commons-codec.txt
       libs/NOTICE_commons-codec.txt
       libs/LICENSE_commons-compress.txt
       libs/NOTICE_commons-compress.txt
       libs/LICENSE_commons-httpclient.txt
       libs/NOTICE_commons-httpclient.txt
       libs/LICENSE_commons-logging.txt
       libs/NOTICE_commons-logging.txt
       libs/LICENSE_gettext-commons.txt
       libs/LICENSE_jackson.txt
       libs/LICENSE_jdom.txt
       libs/LICENSE_jaxen.txt
       libs/LICENSE_xerces.txt
       libs/NOTICE_xerces.txt].each do |path|
        resource path do
          url "https://tools.wmflabs.org/wpcleaner/wpcleaner/#{path}"
        end
      end
  end

  def install
    libexec.install Dir["*"]
    resources.each do |r|
      r.stage (libexec/r.name).parent
    end

    licenses = "#{libexec}/libs"

    (bin/"WPCleaner").write <<~SH
    #!/bin/bash
    exec java -cp "#{libexec}/WPCleaner.jar:#{libexec}/libs/*:#{licenses}" \
         -Dlogback.configurationFile=#{libexec}/logback.xml \
         -Xmx1024M \
         org.wikipediacleaner.WikipediaCleaner \
         $@
    SH
  end

  test do
    # GUI app with no command-line option
    assert (bin/"WPCleaner").executable?
  end
end
