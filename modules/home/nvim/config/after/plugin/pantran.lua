require 'pantran'.setup({
  default_engine = 'deepl',
  engines = {
    deepl = {
      default_target = 'pl',
      preserve_formatting = 1,
    }
  }
})
