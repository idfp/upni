import { useRef } from "react";

const AutoResizableTextarea = ({onChange, ...props}) => {
    const textareaRef = useRef<HTMLTextAreaElement>(null);

    const handleTextareaInput = (x) => {
        if(onChange != null){
            onChange(x)
        }
        const textarea = textareaRef.current;
        if (textarea) {
            textarea.style.height = 'auto';
            textarea.style.height = textarea.scrollHeight + 'px';
        }
    };

    return (
        <textarea
            ref={textareaRef}
            onChange={handleTextareaInput}
            style={{ minHeight: '50px', resize: 'none', overflow: 'hidden' }}
            {...props}
        />
    );
};

export default AutoResizableTextarea;