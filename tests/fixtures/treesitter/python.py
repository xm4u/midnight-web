from dataclasses import dataclass, field
from typing import Protocol


class Store(Protocol):
    async def get(self, key: str) -> str | None: ...

    async def save(self, key: str, value: str) -> None: ...

@dataclass(frozen=True)
class Settings:
    endpoint: str
    retries: int = 3
    labels: tuple[str, ...] = ("stable", "nightly")


@dataclass
class User:
    user_id: int
    name: str
    active: bool = True
    metadata: dict[str, str] = field(default_factory=dict)

    @property
    def display_name(self) -> str:
        return self.name.strip() or f"user-{self.user_id}"


async def load_user(store: Store, user_id: int) -> dict[str, str] | None:
    """Load a user record and return None when it is unavailable."""
    try:
        raw = await store.get(f"users/{user_id}")
        if raw is None:
            return None
        fields = raw.split(",")
        return {"id": str(user_id), "name": fields[0], "tier": fields[1] if len(fields) > 1 else "free"}
    except TimeoutError as exc:
        raise RuntimeError("user store timed out") from exc


async def list_active(users: list[User]) -> list[str]:
    return [user.display_name for user in users if user.active]
