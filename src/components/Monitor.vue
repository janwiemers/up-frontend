<template>
  <div :class="classes">
    <h2>{{ monitor.name }}</h2>
    <span class="monitor-label">{{ monitor.label }}</span>
    <a class="monitor-meta-toggle" href="#" v-on:click="toggleMetaDisplay">{{
      displayMetaText
    }}</a>
    <div v-if="displayMeta" class="monitor-meta">
      <div v-for="key in meta" v-bind:key="key" class="meta-item">
        <h3 class="meta-label">
          {{ key }}
        </h3>
        {{ monitor[key] }}
      </div>
      <div class="meta-item">
        <h3 class="meta-label">
          Interval
        </h3>
        {{ calculateReadableInterval() }}
      </div>
    </div>

    <div class="monitor-history">
      <div>
        <div
          v-for="check in monitor.checks"
          v-bind:key="check.id"
          :class="`monitor-check monitor-up-${check.up} tooltip`"
          :data-tooltip="formatTime(check.createdAt)"
        />
      </div>
      <div class="history-min">{{ getMinTimestamp() }}</div>
      <div class="history-max">{{ getMaxTimestamp() }}</div>
    </div>
  </div>
</template>

<script lang="ts">
import { Options, Vue } from "vue-class-component";
import dayjs from "dayjs";
import { monitorType } from "@/types";

@Options({
  data() {
    return {
      meta: ["target", "protocol", "createdAt"],
      displayMeta: false,
      displayMetaText: "more"
    };
  },

  methods: {
    toggleMetaDisplay() {
      if (this.displayMeta) {
        this.displayMeta = false;
        this.displayMetaText = "more";
      } else {
        this.displayMeta = true;
        this.displayMetaText = "less";
      }
    },
    formatTime(ts: number): string {
      return dayjs(ts).format("YYYY-MM-DD HH:mm");
    },
    getChecksItem(idx: number): monitorType {
      return this.checks[idx];
    },
    getMinTimestamp(): string {
      return "";
      // const firstItem: monitorType = this.getChecksItem(0);
      // if (!firstItem) return "";
      // return this.formatTime(firstItem.createdAt);
    },
    getMaxTimestamp(): string {
      return "";
      // const lastItem: monitorType = this.getChecksItem(this.checks.length - 1);
      // if (!lastItem) return "";
      // return this.formatTime(lastItem.createdAt);
    },
    calculateReadableInterval(): string {
      const i: number = this.monitor.interval / 10000000 / 60;
      return `${Math.floor(i)}s`;
    }
  },

  computed: {
    classes(): string {
      let classes = "up-monitor";
      if (this.monitor.degraded) {
        classes = `${classes} monitor-degraded`;
      }
      return classes;
    }
  },

  props: {
    monitor: null
  }
})
export default class Monitor extends Vue {
  monitor!: monitorType;
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.up-monitor {
  position: relative;
  width: 100%;
}

h2 {
  font-size: 16px;
  display: inline-block;
  margin-right: 10px;
}

h2,
.monitor-history {
  margin-bottom: 5px;
}

.monitor-history {
  width: 100%;
  display: block;
}

.monitor-history:after,
.monitor-history:before {
  content: " ";
  display: block;
  float: none;
  margin-bottom: 40px;
}

.monitor-history:before {
  margin-bottom: 0;
}

.monitor-check {
  height: 20px;
  width: 20px;
  content: " ";
  background: #d9534e;
  display: inline-block;
  margin: 3px;
  border-radius: 3px;
}

.monitor-up-true {
  background: #5cb85b;
}

.monitor-meta {
  background: #fafafa;
  padding: 5px;
  margin-bottom: 10px;
}

.meta-item {
  display: inline-block;
  font-size: 14px;
  width: 295px;
}

.meta-label {
  text-transform: uppercase;
  font-size: 10px;
}
.monitor-meta-toggle {
  text-transform: uppercase;
  position: absolute;
  right: 5px;
  top: 18px;
  font-size: 10px;
  color: #4a4a4a;
  text-decoration: none;
}

.monitor-label {
  font-size: 10px;
  margin: 0 10px;
  text-transform: uppercase;
}

.history-min,
.history-max {
  font-size: 10px;
  text-transform: uppercase;
  float: left;
}
.history-max {
  float: right;
}

.tooltip {
  position: relative;
}

.tooltip:before {
  content: attr(data-tooltip);
  position: absolute;
  top: -30px;
  margin-left: -15px;
  padding: 3px 10px;
  border-radius: 4px;
  background: #000;
  color: #fff;
  text-align: center;
  opacity: 0;
  display: none;
  font-size: 12px;
  white-space: nowrap;
  transition: 0.4s opacity ease-out 0s, 0 display;
}

.tooltip:hover:before {
  opacity: 1;
  display: block;
  transition-delay: 0.4s;
}
</style>
