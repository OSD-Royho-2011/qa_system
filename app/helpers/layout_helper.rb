module LayoutHelper
    
    # Used to achieve nested layouts without content_for
    def parent_layout(layout)
        @view_flow.set(:layout, output_buffer)
        output = render(:template => "#{layout}")
        self.output_buffer = ActionView::OutputBuffer.new(output)
    end
end