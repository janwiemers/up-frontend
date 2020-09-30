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
import axios from "axios";

@Options({
  data() {
    return {
      monitors: [],
      interval: null
    };
  },

  components: {
    Monitor
  },

  methods: {
    async load() {
      try {
        const request = await axios.get("http://localhost:8080/applications");
        this.monitors = request.data;
      } catch (e) {
        console.error(e);
      }
    }
  },

  async mounted() {
    await this.load();
    setInterval(this.load, 10000);
  },

  beforeUnmount() {
    clearInterval(this.interval);
  }
})
export default class Home extends Vue {}
</script>

<style scoped>
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
