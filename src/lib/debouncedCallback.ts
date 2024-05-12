import { useRef, useCallback } from 'react';

type CallbackFunction = (...args: any[]) => void;

const useDebouncedCallback = <T extends CallbackFunction>(
  func: T,
  wait: number
): ((...args: Parameters<T>) => void) => {
  const timeout = useRef<NodeJS.Timeout | null>(null);

  return useCallback(
    (...args: Parameters<T>) => {
      const later = () => {
        if (timeout.current) {
          clearTimeout(timeout.current);
        }
        func(...args);
      };

      if (timeout.current) {
        clearTimeout(timeout.current);
      }

      timeout.current = setTimeout(later, wait);
    },
    [func, wait]
  );
};

export default useDebouncedCallback;