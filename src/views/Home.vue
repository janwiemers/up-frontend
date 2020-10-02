<template>
  <div class="home">
    <div class="headline">
      <h1>up statuspage</h1>
      <img src="./../assets/logo.svg" height="30" />
    </div>
    <div v-for="monitor in monitors" v-bind:key="monitor.ID">
      <Monitor :monitor="monitor" />
    </div>
  </div>
</template>

<script lang="ts">
import { Options, Vue } from "vue-class-component";
import Monitor from "@/components/Monitor.vue";
import { checkType, monitorType } from "@/types";

@Options({
  ws: null,

  data() {
    return {
      monitors: []
    };
  },

  components: {
    Monitor
  },

  methods: {
    replaceMonitors(monitors: monitorType[]) {
      monitors = monitors.map((m: monitorType) => {
        m.checks = [];
        return m;
      });
      this.monitors = monitors;
    },
    addCheck(check: checkType) {
      const idx: number = this.monitors.findIndex(
        (m: monitorType) => m.id == check.applicationId
      );
      if (this.monitors[idx].checks.length > 23) {
        this.monitors[idx].checks.pop();
      }
      this.monitors[idx].checks.push(check);
    },
    addChecks(checks: checkType[]) {
      checks.forEach(this.addCheck);
    }
  },

  mounted() {
    this.ws = new WebSocket("ws://0.0.0.0:8080/ws");
    this.ws.onmessage = (evt: any) => {
      try {
        evt = JSON.parse(evt.data);
      } catch (e) {
        console.log(e);
      }

      const type = evt.type;

      if (type === "monitors") {
        this.replaceMonitors(evt.monitors);
      }

      if (type === "addCheck") {
        this.addCheck(evt.check);
      }

      if (type === "addChecks") {
        this.addChecks(evt.checks);
      }
    };

    this.ws.addEventListener("open", (event: any) => {
      // this.ws.send("Hello Server!");
    });
  }
})
export default class Home extends Vue {}
</script>

<style>
.headline {
  position: relative;
  height: 50px;
  margin-top: 20px;
}

.headline h1 {
  font-size: 24px;
  left: 100px;
  position: absolute;
  margin: 0;
  padding: 0;
}

.headline img {
  position: absolute;
  left: 10px;
  top: 0;
}
</style>
