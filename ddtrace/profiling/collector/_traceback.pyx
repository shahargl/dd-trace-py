cpdef traceback_to_frames(traceback, max_nframes):
    """Serialize a Python traceback object into a list of tuple of (filename, lineno, function_name).

    :param traceback: The traceback object to serialize.
    :param max_nframes: The maximum number of frames to return.
    :return: The serialized frames and the number of frames present in the original traceback.
    """
    tb = traceback
    frames = []
    nframes = 0
    while tb is not None:
        if nframes < max_nframes:
            frame = tb.tb_frame
            code = frame.f_code
            lineno = 0 if frame.f_lineno is None else frame.f_lineno
            frames.insert(0, (code.co_filename, lineno, code.co_name))
        nframes += 1
        tb = tb.tb_next
    return frames, nframes


cpdef pyframe_to_frames(frame, max_nframes):
    """Convert a Python frame to a list of frames.

    :param frame: The frame object to serialize.
    :param max_nframes: The maximum number of frames to return.
    :return: The serialized frames and the number of frames present in the original traceback."""
    frames = []
    nframes = 0
    while frame is not None:
        nframes += 1
        if len(frames) < max_nframes:
            code = frame.f_code
            lineno = 0 if frame.f_lineno is None else frame.f_lineno
            frames.append((code.co_filename, lineno, code.co_name))
        frame = frame.f_back
    return frames, nframes
