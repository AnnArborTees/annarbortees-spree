# HACK
# Damn, so Figaro.env won't work with ['key'] in development, but won't work 
# with .key in test. Wtf? This should settle things once and for all.

Figaro.env.instance_eval do
  def [](key)
    Figaro::ENV.send(key) || Figaro::ENV.fetch(key)
  end
end
