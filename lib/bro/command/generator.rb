module Bro
  class Command
    class Generator
      def initialize(name)
        @name = name
      end

      def self.create(name)
        new(name).generate!
      end

      def generate!
        generate 'command.rb.erb', "bot/commands/#{name}.rb"
        generate 'template.erb', "bot/templates/#{name}.erb"
        generate 'test.rb.erb', "test/commands/#{name}_test.rb"
      end

      private

      def generate(template, path)
        File.write Bro.root.join(path), compile(template)
      end

      def compile(template)
        ERB.new(template_for('command')).result(binding)
      end

      def template_for(name)
        File.read Bro.root.join('lib', 'templates', name)
      end
    end
  end
end
