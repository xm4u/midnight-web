export type Result<T> = { ok: true; value: T } | { ok: false; error: Error };

export interface User {
  readonly id: number;
  name: string;
  role: Role;
}

export type UserPatch = Partial<Pick<User, "name" | "role">>;

export enum Role {
  Reader = "reader",
  Editor = "editor",
}

export interface Repository<T extends { id: number }> {
  readonly label: string;
  find(id: number): Promise<Result<T>>;
  save(value: T): Promise<void>;
}

export class UserService<T extends User> {
  constructor(private readonly repository: Repository<T>) {}

  async load(id: number): Promise<T | null> {
    const result = await this.repository.find(id);
    if (result.ok) return result.value;
    console.warn(`Could not load user ${id}: ${result.error.message}`);
    return null;
  }

  update = async (user: T, patch: UserPatch): Promise<T> => {
    const updated = { ...user, ...patch };
    await this.repository.save(updated);
    return updated;
  };
}

export const retryable = (attempt: number, limit = 3): boolean =>
  attempt > 0 && attempt <= limit;

const normalizeName = (name: string) => name.trim();
export const displayName = normalizeName(" Ada Lovelace ");
