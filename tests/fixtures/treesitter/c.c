#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>

#if __STDC_VERSION__ >= 201112L
#define MAX_ITEMS 32
#else
#define MAX_ITEMS 16
#endif
#define CLAMP(value, low, high) ((value) < (low) ? (low) : ((value) > (high) ? (high) : (value)))

typedef enum {
  STATUS_READY,
  STATUS_BUSY,
  STATUS_FAILED
} Status;

typedef struct {
  const char *name;
  size_t count;
  Status status;
} Queue;

static bool queue_is_ready(const Queue *queue) {
  return queue != NULL && queue->status == STATUS_READY && queue->count < MAX_ITEMS;
}

int main(void) {
  Queue queue = { .name = "build", .count = 3, .status = STATUS_READY };
  size_t available = CLAMP(MAX_ITEMS - queue.count, 0, MAX_ITEMS);
  if (queue_is_ready(&queue)) {
    printf("%s has %zu slots\n", queue.name, available);
  }
  return 0;
}
