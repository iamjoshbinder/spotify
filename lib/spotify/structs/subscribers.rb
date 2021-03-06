module Spotify
  # Spotify::Struct for Subscribers of a Playlist.
  #
  # @attr [Fixnum] count
  # @attr [Array<Pointer<String>>] subscribers
  class Subscribers < Spotify::Struct
    layout :count => :uint,
           :subscribers => [:pointer, 1] # array of pointers to strings

    # Redefined, as the layout of the Struct can only be determined
    # at run-time.
    #
    # @param [FFI::Pointer, Integer] pointer_or_count
    def initialize(pointer_or_count)
      count = if pointer_or_count.is_a?(FFI::Pointer)
        pointer_or_count.read_uint
      else
        pointer_or_count
      end

      layout  = [:count, :uint]
      layout += [:subscribers, [:pointer, count]] if count > 0

      if pointer_or_count.is_a?(FFI::Pointer)
        super(pointer_or_count, *layout)
      else
        super(nil, *layout)
      end
    end
  end
end
