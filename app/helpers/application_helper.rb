module ApplicationHelper

  # Carga los elementos que se hayan definido en el tema actual
  def theme key_sym
    return if not key_sym
    if development?
      development_theme key_sym
    else
      THEME[key_sym.to_s]
    end
  end

  private

  def development?
    Rails.env.development?
  end

  def development_theme key
    YAML.load_file( File.join( Rails.root, "config/theme/theme.yml" ) )[key.to_s]
  end
end
