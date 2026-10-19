import { useCallback, useMemo, useState } from "react";

type Item = { id: string; label: string; done: boolean };
interface Props {
  title: string;
  initialItems?: Item[];
  onSelect?: (item: Item) => void;
}

const MAX_ITEMS = 12;

export function TaskPanel({ title, initialItems = [], onSelect }: Props) {
  const [items, setItems] = useState(initialItems);
  const remaining = useMemo(() => items.filter((item) => !item.done).length, [items]);
  const addItem = useCallback((label: string) => {
    setItems((current) => [...current, { id: crypto.randomUUID(), label, done: false }]);
  }, []);

  return (
    <section aria-label={title} data-count={items.length}>
      <h1>{title}</h1>
      <p className="summary">{remaining} tasks remain</p>
      <ul>
        {items.map((item) => (
          <li key={item.id} data-done={item.done}>
            <button className="task-link" onClick={() => onSelect?.(item)}>
              {item.label}
            </button>
          </li>
        ))}
      </ul>
      <button disabled={items.length >= MAX_ITEMS} onClick={() => addItem("New task")}>
        Add task
      </button>
    </section>
  );
}

export const Preview = () => <TaskPanel title="Preview" initialItems={[]} />;
